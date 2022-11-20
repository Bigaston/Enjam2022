const fs = require("fs")
const path = require("path")
const spawn = require("child_process").spawn;

let folders = fs.readdirSync(path.join(__dirname, "./todo"))
let files = []
let outputFiles = []

folders.forEach(folder => {
  if (!fs.existsSync(path.join(__dirname, "./output/", folder))) fs.mkdirSync(path.join(__dirname, "./output/", folder))

  let soundToPlay = fs.readdirSync(path.join(__dirname, "./todo/", folder))

  soundToPlay.forEach(sound => {
    files.push(path.join(__dirname, "./todo/", folder, sound))
    outputFiles.push(path.join(__dirname, "./output/", folder, sound))
  })
})

console.log(files)
generateVideo(files, outputFiles)

function generateVideo(files, outputFiles) {
  promisedSpawn("ffmpeg", [
    "-y",
    "-i",
    files[0],
    "-acodec",
    "adpcm_ima_wav",
    outputFiles[0],
  ]).then(() => {
    console.log(files[0] + " ok");

    let newFile = [...files];
    newFile.shift();

    let newFileOutput = [...outputFiles];
    newFileOutput.shift();

    if (newFile.length !== 0) {
      generateVideo(newFile, newFileOutput);
    } else {
      console.log("Travail terminé!");
    }
  });
}

function promisedSpawn(command, params) {
  console.log(params);

  return new Promise((resolve, reject) => {
    var ol = spawn(command, params, { cwd: __dirname });

    ol.stdout.on("data", function (data) {
      console.log(data.toString());
    });

    ol.stderr.on("data", function (data) {
      console.log(data.toString());
    });

    ol.on("close", function (code) {
      resolve();
    });
  });
}