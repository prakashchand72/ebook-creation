#!/bin/bash
set -e

if [ $# -ne 2 ]; then
  echo "Usage: htmltopdf input.html output.pdf"
  exit 1
fi

INPUT=$(realpath "$1")
OUTPUT=$(realpath "$2")

node -e "
const p=require('puppeteer'),path=require('path');
(async()=>{
  const b=await p.launch({executablePath:'/usr/bin/chromium',args:['--no-sandbox']});
  const pg=await b.newPage();
  await pg.goto('file://$INPUT',{waitUntil:'networkidle0'});
  await pg.pdf({path:'$OUTPUT',format:'A4',printBackground:true,displayHeaderFooter:false,margin:{top:0,bottom:0,left:0,right:0}});
  await b.close();
  console.log('Saved: $OUTPUT');
})()
"
