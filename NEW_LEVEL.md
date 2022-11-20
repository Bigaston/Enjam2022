# New Level Documentation
If you want to add a level, follows theses steps:

## Add a level
If you want to add a level, you can add a JSON file in `levels` folder based on this file
```JSON
{
  "levelName": "Level name",
  "checkpoints": [], // Array of checkpoints point to move to [x, y]
  "backgroundImage": "", // Background image that show the drawing you have to draw
  "winDialogue": "", // Dialogue to display if win
  "looseDialogue": "", // Dialogue to display if loose
  "difficulty": 1 // Not used for now
}
```

## Add some dialogues
If you want to add a dialogue, put a JSON file in `vn/dialogues/en` and on `vn/dialogues/fr` based on this one.
For the image, you can use [ditherit](https://ditherit.com/)
```JSON
[
  {
    "text": "The text of the dialogue. Supports\nfor line returns", 
    "speed": 1, // Number of frame between each letter during the opening animation
    "author": "", // Optionnal, author
    "image": "", // Optionnal, path to an image, need to be 198 height
    "audio": "", // Optionnal, path to a audio file to be played when the dialog is showed
    "effect": "" // Optionnal, effect on the image: shake, blink, invert
  }
]

```