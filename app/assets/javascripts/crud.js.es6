$(document).ready(() => {
  (function listenForCrud() {
    getLinks()
    createLink()
    updateStatus()
  }())
})

function getLinks() {
  let request = new Request('/api/v1/links.json', { method: 'GET', credentials: 'same-origin' })

  fetch(request)
    .then(response => response.json())
    .then(response => response.forEach(link => appendRow(link)))
    .catch(err => console.log(err))
}

function createLink() {
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
      <td id='update-status-${link.id}'><button type='button' class='update-status btn btn-sm'>Mark as Read</button></td>
    </tr>`
  )
}

function updateStatus() {
  $("#links-table").on('click', '.update-status', e => {
    let target = e.currentTarget
    let linkID = $(target).parent()[0].id.replace(/^\D+/g, "")

    let currentStatus = $(target).parent().prev()[0].innerText
    let updateStatus =  currentStatus === "false" ? true : false

    let edit_data = { link: { read: updateStatus } }
    updateAjax(target, edit_data, linkID)
  })
}

function toggleReadText(target, status) {
  $(target).parent().prev().text(status)
  $(target).text(toggleButtonText(status))
}

function toggleButtonText(status) {
  return status ? "Mark as Unread" : "Mark as Read"
}

function updateAjax(target, edit_data, linkID) {

  $.ajax({
    url: "/api/v1/links/" + linkID,
    type: "PATCH",
    dataType: "JSON",
    data: edit_data,
    success: response => {
      toggleReadText(target, response.read)
    },
    error: error => {
      console.log(error)
    }
  })
}
