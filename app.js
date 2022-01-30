// TODO: stocker le dictionnaire sous sa forme évoluée en JSON

import { PuppeteerScreenRecorder } from "puppeteer-screen-recorder"
import puppeteer from "puppeteer"
import { readFileSync } from "fs"

/*
 * Chargement du dictionnaire de mots sous cette forme :
 *    dictionnaire = {
 *      6: {
 *        "A": [ "ABRUTI", "AIRBAG", ... ],
 *        "B": [ ... ],
 *        ...
 *      },
 *      7: { ... },
 *      ...
 *    }
 *
 * Au début de chaque partie, nous connaissons le nombre de lettre ainsi que la
 * première lettre du mot à deviner. Cette factorisation permettra de filtrer
 * directement les mots éligibles.
 */

const mots = readFileSync("data/mots.txt", "utf8").split("\n")
const dictionnaire = {}

mots.forEach((mot) => {
  const taille = mot.length
  const [premiereLettre] = mot

  if (Object.hasOwn(dictionnaire, taille)) {
    if (Object.hasOwn(dictionnaire[taille], premiereLettre)) {
      dictionnaire[taille][premiereLettre].push(mot)
    } else {
      dictionnaire[taille][premiereLettre] = [mot]
    }
  } else {
    dictionnaire[taille] = { [premiereLettre]: [mot] }
  }
})

/*
 * Ouverture de la page web via Puppeteer
 */

const now = Date.now()

const run = async () => {
  // Création du navigateur Puppeteer et de la page de navigation
  const browser = await puppeteer.launch({
    defaultViewport: null,
    headless: false,
    slowMo: 0
  })
  const page = await browser.newPage()

  // // Démarrage de l'enregistrement de la navigation
  // const recorder = new PuppeteerScreenRecorder(page)
  // await recorder.start(`sessions/${now}_video.mp4`)

  await page.goto("https://sutom.nocle.fr/")

  // Identification de la longueur et première lettre du mot à trouver
  await page.waitForSelector("#grille tr")
  const [tailleMot, premiereLettre] = await page.$eval(
    "#grille tr",
    (grille) => [grille.childElementCount, grille.childNodes[0].textContent]
  )

  let motsPossibles = dictionnaire[tailleMot][premiereLettre]
  let indiceLigneSuivante = 1

  // Tant que le mot n'est pas trouvé (tout rouge)
  while (true) {
    // Vérification que la partie n'est pas terminée
    const partieTerminee = await page.evaluate(() => {
      const panel = document.getElementById("fin-de-partie-panel")
      return window.getComputedStyle(panel).display === "block"
    })
    // console.log(partieTerminee)

    if (partieTerminee) {
      break
    }

    // TODO: Mise à jour des mots proposables
      // Récupération des informations données par la grille (anciens essais)
      // Réduction des mots possibles
        // Certes, le nombre de mots réellement possibles est réduit, mais le résultat de l'analyse en fréquence de lettres peut conduire à tester un mot en dehors de ce sous-ensemble.

    // TODO: Choix du mot à proposer
    // const proposition = motsPossibles[Math.floor(Math.random() * motsPossibles.length)]

    // 1. Créer un dictionnaire de fréquences des lettres parmi les mots éligibles restants
    const frequences = {}

    for (const mot of motsPossibles) {
      const lettresUniques = new Set(mot.slice(1))

      for (const lettre of lettresUniques) {
        if (Object.hasOwn(frequences, lettre)) {
          frequences[lettre]++
        } else {
          frequences[lettre] = 1
        }
      }
    }
    console.log(frequences)

    // 2. Trouver le mot qui élimine les lettres les plus fréquentes parmi l'ENSEMBLE des mots proposables
    const lettresTriees = Object.keys(frequences).sort ((a, b) => frequences[b] - frequences[a])
    let nbLettresAPiocher = tailleMot - 1
    const motsProposables = []

    while (true) {
      const lettresAChercher = lettresTriees.slice(0, nbLettresAPiocher).reverse()
      console.log(lettresAChercher)

      // Trouver tous les mots qui contiennent ces lettres
      for (const mot of motsPossibles) {
        let motEligible = true

        for (const lettre of lettresAChercher) {
          if (!mot.includes(lettre)) {
            motEligible = false
            break
          }
        }

        if (motEligible) {
          motsProposables.push(mot)
        }
      }

      console.log(motsProposables)

      if (motsProposables.length > 0) {
        break
      } else {
        nbLettresAPiocher++

        break
      }
    }

    break

    // Soumission du mot avec le clavier
    for (const lettre of proposition) {
      const touche_clavier = `Key${lettre}`
      await page.keyboard.press(touche_clavier)
    }
    await page.keyboard.press("Enter")

    // Attente de la résolution du mot proposé    
    if (indiceLigneSuivante < 6) {
      await page.waitForFunction(
        (indiceSuivant, premiereLettreMot) => {
          const panel = document.getElementById("fin-de-partie-panel")
          const partieTerminee = window.getComputedStyle(panel).display === "block"
  
          const premiereLettreSuivante = document.querySelector("#grille table").childNodes[indiceSuivant].firstChild.textContent

          return partieTerminee || premiereLettreSuivante === premiereLettreMot
        }, {}, indiceLigneSuivante, premiereLettre)
    } else {
      await page.waitForTimeout(3000)
    }

    // Préparation de la prochaine itération
    indiceLigneSuivante = indiceLigneSuivante + 1
  }

  // // Arrêt de l'enregistrement et capture de l'écran final
  // await recorder.stop()
  await page.screenshot({ path: `sessions/${now}_image.png` })
  await browser.close()
}

run()
