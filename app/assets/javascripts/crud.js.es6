$(document).ready(() => {
  (function listenForCrud() {
    getLinks()
  }())
})

function getLinks() {
  let request = new Request('/api/v1/links.json', { method: 'GET', credentials: 'same-origin' })

  fetch(request)
    .then(response => response.json())
    .then(response => response.forEach(link => appendRow(link)))
    .catch(err => console.log(err))
}

function appendRow(link) {
  $("#table-body").prepend(
    `<tr id='link-${link.id}'>
      <td contenteditable='true' class='title input' id='title-${link.id}'>${link.title}</td>
      <td contenteditable='true' class='input' id='url-${link.id}'>${link.url}</td>
      <td id='read-${link.id}'>${link.read}</td>
    </tr>`
  )
}
