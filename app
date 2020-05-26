document.addEventListener('DOMContentLoaded', () => {
  const grid = document.querySelector('.grid')
  let squares = Array.from(document.querySelectorAll('.grid div'))
  const ScoreDisplay = document.querySelector('#score')
  const StartBtn = document.querySelector('#start-button')
  const width = 10
  let nextRandom = 0

  //The Tetrominoes
  const lTetromino = [
    [1, width+1, width*2+1, 2],
    [width, width+1, width+2, width*2+2],
    [1, width+1, width*2+1, width*2],
    [width, width*2, width*2+1, width*2+2]
  ]

  const zTetromino = [
    [0,width,width+1,width*2+1],
    [width+1, width+2,width*2,width*2+1],
    [0,width,width+1,width*2+1],
    [width+1, width+2,width*2,width*2+1]
  ]

  const tTetromino = [
    [1,width,width+1,width+2],
    [1,width+1,width+2,width*2+1],
    [width,width+1,width+2,width*2+1],
    [1,width,width+1,width*2+1]
  ]

  const oTetromino = [
    [0,1,width,width+1],
    [0,1,width,width+1],
    [0,1,width,width+1],
    [0,1,width,width+1]
  ]

  const iTetromino = [
    [1,width+1,width*2+1,width*3+1],
    [width,width+1,width+2,width+3],
    [1,width+1,width*2+1,width*3+1],
    [width,width+1,width+2,width+3]
  ]

  const theTetrominoes = [lTetromino, zTetromino, tTetromino, oTetromino, iTetromino]

  let currentPosition = 4
  let currentRotation = 0
  //randomly select a Tetromino and its first rotation
  let random = Math.floor(Math.random()*theTetrominoes.length)
  let current = theTetrominoes[random][0]

  //draw the Tetromino
  function draw() {
    current.forEach(index => {
      squares[currentPosition + index].classlist.add('tetromino')
    })
  }

//undraw the Tetrominoes
  function undraw() {
    current.forEach(index => {
      squares[currentPosition + index].classlist.remove('tetromino')
    })
  }

  //make the tetromino move down every second
  timerID = setInterval(movedown, 1000)

//assign functions to keyCodes
function control(e) {
  if(e.keycode === 37) {
    moveLeft()
  } else if (e.keyCode === 38) {
    rotate()
  } else if (e.keyCode === 39) {
    moveRight()
  } else if (e.keyCode === 40) {
    moveDown()
  }
}
document.addEventListener('keyup', control)

  //move down function
  function moveDown () {
    undraw()
    currentPosition += width
    draw()
    freeze()
  }

  //freeze function
  function freeze() {
    if(current.some(index => squares[currentPosition + index + width].classlist.contains('taken'))) {
      current.forEach(index =>squares[currentPosition + index].classlist.add('taken'))
      //start a new tetromino falling
      random = nextRandom
      nextRandom = Math.floor(Math.random() * theTetrominoes.length)
      current = theTetrominoes[random][currentRotation]
      currentPosition = 4
      draw()
      displayShape()
    }
  }

  //move the tetromino left, unless is at the edge or there is a blockage
function moveLeft () {
  undraw()
  const isAtLeftEdge = current.some(index => (currentPosition + index) % width  === 0)

if (!isAtLeftEdge) currentPosition -=1

if(current.some(index => squares[currentPosition + index].classlist.contains('taken')))
    currentPosition +=1
  }

draw()

})

//move the tetromino right, unlesss is at the edge or there is a blockage
function moveRight() {
  undraw()
  const isAtRightEdge = current.some(index => (currentPosition +index) % width === width -1)

  if(!isAtRightEdge) currentPosition +=1

  if(current.some(index => squares[currentPosition +index].classList.contains('taken'))) {
    currentPosition -=1
  }

  draw()
}

  //rotate the tetromino
  function rotate() {
    undraw()
    currentRotation ++
    if(currentRotation === current.length) { //if the current rotation gets to 4, make it go back to 0
      currentRotation = 0
    }
    current = theTetrominoes[random][currentRotation]
    draw()
  }

  //show up-next tetromino in mini-grid
  const displaySquares = document.querySelectorAll('.mini-grid div')
  const displayWidth = 4
  let displayIndex = 0
  let nextRandom = 0

  //the Tetrominoes without rotations
  const upNextTetrominoes = [
    [1, displayWidth+1, displayWidth*2+1, 2], //lTetromino
    [0, displayWidth, displayWidth+1, displayWidth*2+1], //zTetromino
    [1, displayWidth, displayWidth+1, displayWidth2], //theTetromino
    [0, 1, displayWidth, displayWidth+1], //oTetromino
    [1, displayWidth+1, displayWidth*2+1, displayWidth*3+1] //iTetromino
  ]

  //display the shape in the mini-grid display
  function displayShape () {
    displaySquares.forEach(square => {
      square.classlist.remove('tetromino')
    })
    upNextTetrominoes[nextRandom].forEach ( indedx => {
      displaySquares[displayIndex + index].classList.add('tetromino')
  })
