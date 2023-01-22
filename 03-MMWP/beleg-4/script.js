/*
    HINWEIS:
    Ich habe mich absichtlich dagegen entschieden, keine Meldung anzuzeigen, 
    wenn jemand auf ein ungültiges Feld klickt, da es m.M.n. den Spielfluss stört.
    Gültige Felder erkennt man auch so, da der Cursor sich ändern, wenn man über
    sie hovert. 
    Zudem hat ein Klick auf ein ungültiges Feld keinerlei Auswirkungen.
    Aus dem selben Grund habe ich mich auch dagegen entschieden, einen Timer einzubauen.
    Sollte der Timer (zum Mausklick-Abfangen) zwingend erforderlich sein, reiche ich ihn gerne nach.
*/

const boardHeight = 600;
const boardWidth = 600;
const gapSize = 16;
const cellHeight = boardHeight / 3 - gapSize;
const cellWidth = boardWidth / 3 - gapSize;
const cellPadding = 48;

const lineWidth = 12;
const lineCap = "round";

const playerX = "X";
const playerXColor = "#FFF854";
const playerO = "O";
const playerOColor = "#FF5353";
const drawColor = "#53B7FF";
const defaultColor = "white";

const initialBoardLayout = [  
    ["", "", ""],
    ["", "", ""],
    ["", "", ""]
];

const labelMessage = ["ist am Zug.", "ist an der Reihe.", "muss wählen.", "ist dran."];
const labelWonMessage = ["hat gewonnen!", "ist der Gewinner!", "ist der Sieger!"];
const labelDrawMessage = ["Unentschieden!", "Keiner hat gewonnen!", "Kein Sieger!"];

var label = document.getElementById("label");
var board = document.getElementById("board");
var tiles = document.querySelectorAll("#board > canvas");
var restartButton = document.getElementById("restartButton");
let hasGameEnded;
let player;
let boardLayout;

/**
 * Initialisiert die Elemente im Spiel und vergibt Startwerte.
 * Jedem Feld und dem Restart-Button wird ein Event-Listener hinzugefügt, 
 * der auf Klicks reagiert.
 */
function startGame() {
    changeLoserOpacity(1);
    board.style.height = boardHeight + "px";
    board.style.width = boardWidth + "px";
    board.style.gap = gapSize + "px";
    label.style.color = defaultColor;
    hasGameEnded = false;
    player = playerX;
    boardLayout = initialBoardLayout;
    updateLabel();

    tiles.forEach((tile) => {
        tile.setAttribute("class", "empty");
        tile.addEventListener('click', tileClicked, false);
        tile.getContext("2d").clearRect(0, 0, cellWidth, cellWidth);
        tile.height = cellHeight;
        tile.width = cellWidth;
    });

    restartButton.addEventListener('click', restartGame, false);
}

/**
 * Wird ausgeführt, wenn auf ein Feld geklickt wird.
 * Nur, wenn das Feld leer ist, wird es mit dem aktuellen Spieler belegt.
 * Zudem wird überprüft, ob jemand gewonnen hat bzw. das Spiel vorbei ist.
 * @param {*} event Event-Objekt, das Informationen über das Event enthält.
 */
function tileClicked(event) {
    if (hasGameEnded) return;
    const cellX = event.target.id.split(" ")[0];
    const cellY = event.target.id.split(" ")[1];
    if (boardLayout[cellX][cellY] === "") {
        boardLayout[cellX][cellY] = player;
        (player === playerX) ? drawX(event.target) : drawO(event.target);
        checkForWinner();
        if (!hasGameEnded) player = (player === playerX) ? playerO : playerX;
        updateLabel();
    }
}

/**
 * Trifft Einstellungen für das Canvas-Element und gibt das Context-Objekt zurück.
 * @param {*} canvas, das Canvas-Element, für das die Einstellungen getroffen werden sollen.
 * @returns {*} Context-Objekt des Canvas-Elements
 */
function getContext(canvas) {
    var context = canvas.getContext("2d");
    context.lineWidth = lineWidth;
    context.lineCap = lineCap;
    context.strokeStyle = player === playerX ? playerXColor : playerOColor;
    return context;
}

/**
 * Zeichnet ein X in das übergebene Canvas-Element.
 * @param {*} canvas: das Canvas-Element, in das das X gezeichnet werden soll.
 */
function drawX(canvas) {
    const startX = cellPadding;
    const startY = cellPadding;
    const endX = startX + cellWidth - cellPadding * 2;
    const endY = startY + cellHeight - cellPadding * 2;
    var context = getContext(canvas);
    context.beginPath();
    context.moveTo(startX, startY);
    context.lineTo(endX, endY);
    context.moveTo(endX, startY);
    context.lineTo(startX, endY);
    context.stroke();
    canvas.setAttribute("class", "x");
}

/**
 * Zeichnet einen Kreis in das übergebene Canvas-Element.
 * @param {*} canvas: das Canvas-Element, in das der Kreis gezeichnet werden soll.
 */
function drawO(canvas) {
    const centerX = cellWidth / 2;
    const centerY = cellHeight / 2;
    const shorterSide = cellWidth > cellHeight ? cellHeight : cellWidth;
    const radius = shorterSide / 2 - cellPadding;
    var context = getContext(canvas);
    context.beginPath();
    context.arc(centerX, centerY, radius, 0, 2 * Math.PI);
    context.stroke();
    canvas.setAttribute("class", "o");
}

/**
 * Aktualisiert den Text über dem Spielbrett.
 * Wenn es ein Unentschieden gibt, wird eine zufällige Meldung aus dem Array labelDrawMessage angezeigt.
 * Wenn jemand gewonnen hat, wird eine zufällige Meldung aus dem Array labelWonMessage angezeigt.
 * Ansonsten zeigt es eine zufällige Meldung aus dem Array labelMessage an.
 */
function updateLabel() {
    const message = labelMessage[Math.floor(Math.random() * labelMessage.length)];
    const wonMessage = labelWonMessage[Math.floor(Math.random() * labelWonMessage.length)];
    const drawMessage = labelDrawMessage[Math.floor(Math.random() * labelDrawMessage.length)];
    var isDrawed = boardLayout.flat().every(tile => tile !== "");
    if (isDrawed) {
        label.innerHTML = drawMessage;
        label.style.color = drawColor;
    } else if (hasGameEnded) {
        label.innerHTML = player + " " + wonMessage;
        label.style.color = player === playerX ? playerXColor : playerOColor;
    } else {
        label.innerHTML = player + " " + message;
    }
}

/**
 * Überprüft ob der aktuelle Spieler gewonnen hat.
 * Wenn ja, dann wird das Spiel beendet.
 */
function checkForWinner() {
    var isDrawed = boardLayout.flat().every(tile => tile !== "");
    if (checkRowsForWinner() === player || 
        checkColumnsForWinner() === player || 
        checkDiagonalsForWinner() === player ||
        isDrawed) {
            finishGame();
    }
}

/**
 * Überprüft ob der aktuelle Spieler vertikal gewonnen hat.
 * @returns {string} player, wenn der aktuelle Spieler gewonnen hat, ansonsten null.
 */
function checkRowsForWinner() {
    for (let i = 0; i < boardLayout.length; i++) {
        var score = 0;
        boardLayout[i].forEach(tile => tile === player ? score++ : null);
        if (score === boardLayout.length) return player;
    }
}

/**
 * Überprüft ob der aktuelle Spieler horizontal gewonnen hat.
 * @returns {string} player, wenn der aktuelle Spieler gewonnen hat, ansonsten null.
 */
function checkColumnsForWinner() {
    for (let i = 0; i < boardLayout.length; i++) {
        var score = 0;
        boardLayout.forEach(tile => tile[i] === player ? score++ : null);
        if (score === boardLayout.length) return player;
    }
}

/**
 * Überprüft ob der aktuelle Spieler diagonal gewonnen hat.
 * @returns {string} player, wenn der aktuelle Spieler gewonnen hat, ansonsten null.
 */
function checkDiagonalsForWinner() {
    var score = 0;
    for (let i = 0; i < boardLayout.length; i++) {
        boardLayout[i][i] === player ? score++ : null;
    }
    if (score === boardLayout.length) return player;
    
    score = 0;
    for (let i = 0; i < boardLayout.length; i++) {
        boardLayout[boardLayout.length - 1 - i][i] === player ? score++ : null;
    }
    if (score === boardLayout.length) return player;
}

/**
 * Ändert die Deckkraft aller nicht gewinnenden Felder.
 * @param {*} opacity Neue Deckkraft.
 */
function changeLoserOpacity(opacity) {
    tiles.forEach(tile => {
        var matchesWinner = tile.classList.contains("x") && player === playerX ||
                            tile.classList.contains("o") && player === playerO
        if (!matchesWinner) {
            tile.style.opacity = opacity;
        }
    });
}

/**
 * Beendet das Spiel.
 * Alle leeren Felder zeigen keine Pointer-Cursor mehr und
 * die Deckkraft aller nicht gewinnenden Felder wird reduziert.
 */
function finishGame() {
    tiles.forEach(tile => tile.classList.contains("empty") 
        ? tile.setAttribute("class", "emptyWithoutPointer") 
        : null);
    hasGameEnded = true;
    changeLoserOpacity(0.24);
    updateLabel();
}

/**
 * Startet das Spiel neu.
 */
function restartGame() {
    resetBoardLayout();
    startGame();
}

/**
 * Setzt das Spielfeld zurück.
 */
function resetBoardLayout() {
    for (let i = 0; i < boardLayout.length; i++) {
        for (let j = 0; j < boardLayout.length; j++) {
            boardLayout[i][j] = "";
        }
    }
}

/**
 * Startet das Spiel beim Laden der Seite.
 */
window.onload = function() {
    startGame();
}