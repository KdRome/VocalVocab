# VocalVocab

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

VocalVocab is the interactive way to master spelling and expand your vocabulary! Designed for learners of all levels, VocalVocab transforms your mobile device into a personal spelling tutor. Whether you're studying for a spelling bee, learning a second language, or just brushing up on your word skills, VocalVocab offers a unique and engaging educational experience.

### App Evaluation

- **Category:** Education
- **Mobile:** Uses Audio, Real-Time, Notifications(maybe)
- **Story:** Learners, Competitive Spellers. Allows users to improve the spelling of words that they hear. Users might find this application engaging if they are interested in self-improvement, education, or language mastery
- **Market:** Educational Institutions, Individual Learners, Global Non-English Speakers (more languages can potentially be added)
- **Habit:** Daily Practices, Progress Tracking. Can track the user's progress. Users can open this application daily to improve their language skills. The average user consumes the content.
- **Scope:** It may be challenging to build a perfect version of this app. It would still be interesting to build a stripped-down version of this app.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [x] User can hear the given word
* [x] User can hear the description of the given word
* [x] User can adjust how many letters they want the word to be
* [x] User can see which words they have answered previously
* [x] User can retry the word if they get it wrong

**Optional Nice-to-have Stories**

* User gets 3 tries to get the spelling correctly
* User can see their streak of correct answers
* User can change the speed of the playback audio

### 2. Screen Archetypes

- [X] Play Screen
* Press play to listen to the word
* Press play to listen to the description of the word

- [X] Replay Screen
* Users can retry the word if they get it wrong
* User gets notified if they get it wrong and can try as many times as they wish

- [X] Settings Screen
* User can adjust how many letters they want the word to be

- [X] Completed Screen
* User can see which words they have answered correctly
* User can replay words they completed

### 3. Navigation

**Tab Navigation** (Tab to Screen)
* Home Screen
* Settings Screen
* Completed Screen

**Flow Navigation** (Screen to Screen)

- [X] Play Screen
* => Completed

- [X] Replay Screen
* => Play Screen
or 
* => None

- [X] Completed Screen
* => Home

- [X] Settings
* => None

## Wireframes

![IMG_F70FFFBC0C99-1](https://hackmd.io/_uploads/rkDiEInQ6.jpg)

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

![Simulator Screen Recording - iPhone 13 Pro Test - 2023-11-17 at 20 18 04](https://github.com/KdRome/VocalVocab/assets/119768219/cc658182-983b-49c6-a785-07ae5cc119bd)

## Schema 

### Models

#### WordClass

| Property      | Type     | Description |
| ------------- | -------- | ----------- |
| word          | String   | The word itself |
| nounDefinition| String?  | The definition of the word when used as a noun |
| verbDefinition| String?  | The definition of the word when used as a verb |

- `WordClass`: Represents a word with its possible noun and verb definitions.
- `WordDataModel`: Collection of `WordClass` instances, including saving and loading from UserDefaults.


### Networking

#### Word & Definition Fetching

- (GET) Query Word
   ```swift
   func fetchWords(completion: @escaping ([String]) -> Void) {
       let randomWordsURL = URL(string: "https://random-word-api.herokuapp.com/word?length=\(wordLength)")!
   }
   
- (GET) Query Word Definition
   ```swift
   func fetchDefinitions(for word: String, completion: @escaping (WordClass, Bool) -> Void) {
        let definitionURLString = "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)"
   }
