# VocalVocab

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

VocalVocab, the interactive way to master spelling and expand your vocabulary! Designed for learners of all levels, VocalVocab transforms your mobile device into a personal spelling tutor. Whether you're studying for a spelling bee, learning a second language, or just brushing up on your word skills, VocalVocab offers a unique and engaging educational experience.

### App Evaluation

- **Category:** Education
- **Mobile:** Uses Audio, Real-Time, Notifications(maybe)
- **Story:** Learners, Competitive Spellers. Allows users to improve the spelling of words that they hear. Users might find this application engaging if they are interested in self-improvement, education, or language mastery
- **Market:** Educational Institutions, Individual Learners, Global Non-English Speakers (more languages can potentially be added)
- **Habit:** Daily Practices, Progress Tracking. Can track the users progress. Users can open this application daily to improve their language skills. The average user consumes the content.
- **Scope:** It may be challenging to build a perfect version of this app. It would still be interesting to build a stripped-down version of this app.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can hear the given word
* User can hear the description of the given word
* User can adjust how many letters they want the word to be
* User can see which words they have answered previously
* User can retry the word if they get it wrong

**Optional Nice-to-have Stories**

* User gets 3 tries to get the spelling correctly
* User can see their streak of correct answers
* User can change the speed of the playback audio

### 2. Screen Archetypes

- [ ] Play Screen
* Press play to listen to the word
* Press play to listen to the description of the word

- [ ] Replay Screen
* User can retry the word if they get it wrong

- [ ] Settings Screen
* User can adjust how many letters they want the word to be

- [ ] Completed Screen
* User can see which words they have answered correctly
* User can replay words they completed

### 3. Navigation

**Tab Navigation** (Tab to Screen)
* Home Screen
* Settings Screen
* Completed Screen

**Flow Navigation** (Screen to Screen)

- [ ] Play Screen
* => Completed

- [ ] Replay Screen
* => Play Screen
or 
* => None

- [ ] Completed Screen
* => Home

- [ ] Settings
* => None

## Wireframes

![IMG_F70FFFBC0C99-1](https://hackmd.io/_uploads/rkDiEInQ6.jpg)

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

[This section will be completed in Unit 9]

### Models

[Add table of models]

### Networking

- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
