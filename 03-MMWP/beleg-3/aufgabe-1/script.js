function initiateBoard() {
   const images = document.querySelectorAll('#picturesbox > img');
   for (let i = 0; i < images.length; i++) {
      images[i].addEventListener('dragstart', dragstart, false);
   }

   const dropboxes = document.querySelectorAll('#dropbox > div, #picturesbox');
   for (let i = 0; i < dropboxes.length; i++) {
      dropboxes[i].addEventListener('dragover', dragover, false);
      dropboxes[i].addEventListener('dragleave', dragleave, false);
      dropboxes[i].addEventListener('drop', drop, false);   
   }
}

function dragstart(e) {
   e.dataTransfer.setData('text/plain', e.target.id);
   e.dataTransfer.dropEffect = 'move';
}

function dragover(e) {
   e.preventDefault();
   if (e.target.nodeName != "IMG") {
      e.target.style.opacity = 0.5;
   } 
}

function dragleave(e) {
   e.target.style.opacity = 1;
}

function drop(e) {
   e.preventDefault();
   e.target.style.opacity = 1;
   if (isTargetValid(e)) {
      if (e.target.parentElement.id === "trash") {
         elementOf(e).remove();
      } else {
         e.target.appendChild(elementOf(e));
      }
   } else {
      alert("Das Bild passt nicht in dieses Feld!");
   }
}

function isTargetValid(e) {
   if (e == null) return false;
   const tolerance = elementOf(e).naturalWidth * 0.1;
   const isSquare = Math.abs(elementOf(e).naturalWidth - elementOf(e).naturalHeight) < tolerance;
   const isLandscape = elementOf(e).naturalWidth > elementOf(e).naturalHeight + tolerance;
   const isPortrait = elementOf(e).naturalHeight > elementOf(e).naturalWidth + tolerance;
   return (
      e.target.classList.contains("breit") && isLandscape || 
      e.target.classList.contains("quadrat") && isSquare || 
      e.target.classList.contains("hoch") && isPortrait ||
      e.target.id === "picturesbox" ||
      e.target.parentElement.id === "trash"
   );
}

function elementOf(e) {
   if (e == null) return false;
   const elementId = e.dataTransfer.getData('text/plain');
   return document.getElementById(elementId);
}

window.addEventListener('load', initiateBoard, false);