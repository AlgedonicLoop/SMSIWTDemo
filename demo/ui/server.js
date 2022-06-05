const express = require('express')
const path = require('path')

const app = express()
const port = process.env.PORT || 8080

app.use(express.static('dist/ui'));

app.listen(port, () => {
  console.log(`UI server app listening on port ${port}`)
})
