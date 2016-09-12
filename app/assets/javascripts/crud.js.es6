$(document).ready(() => {
  (function listenForCrud() {
    getLinks()
    createIdea()
  }())
})

function getLinks() {
  let request = new Request('/api/v1/links.json', { method: 'GET', credentials: 'same-origin' })

  fetch(request)
    .then(response => response.json())
    .then(response => response.forEach(link => appendRow(link)))
    .catch(err => console.log(err))
}

function createIdea() {
  $("#submit-link").on('click', e => {
    e.preventDefault()
    var newData = $("#new-link").serialize()

    $.ajax({
      url: "/api/v1/links",
      type: "POST",
      dataType: "JSON",
      data: newData,
      success: response => {
        appendRow(response)
        clearFields()
      },
      error: error => {
        appendErrorRow(error)
        console.log(error)
      }
    })
  })
}

function clearFields() {
  $("#title-field").val("")
  $("#url-field").val("")
  $('bg-danger').val("")
}

function appendErrorRow(error) {
  $("#table-body").prepend(`<tr class='bg-danger'><td colspan='3'>${error.responseText}</td></tr>`)
}

function appendRow(link) {
  $("#table-body").prepend(
    `<tr id='link-${link.id}'>
      <td contenteditable='true' class='title input' id='title-${link.id}'>${link.title}</td>
      <td contenteditable='true' class='input' id='url-${link.id}'>${link.url}</td>
      <td id='read-${link.id}'>${link.read}</td>
      <td id='update-status-${link.id}'><button type='button' class='btn btn-sm'>Mark as Read</button></td>
    </tr>`
  )
}
