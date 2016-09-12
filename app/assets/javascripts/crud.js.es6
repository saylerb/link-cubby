$(document).ready(() => {
  (function listenForCrud() {
    getLinks()
    createLink()
    updateStatus()
    updateLinkText()
    search()
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
        console.log(error)
        appendErrorRow(error.responseText)
      }
    })
  })
}

function clearFields() {
  $("#title-field").val("")
  $("#url-field").val("")
  $('.bg-danger').remove()
}

function appendErrorRow(error) {
  if (($('.bg-danger').length) < 1 ) {
    $("#table-body").prepend(`<tr class='bg-danger'><td colspan='4'>${error}</td></tr>`)
  }
}

function appendRow(link) {
  let style = link.read ? 'bg-success' : ''
  let buttonText = link.read ? 'Mark as Unread' : 'Mark as Read'

  $("#table-body").prepend(
    `<tr id='link-${link.id}' class=${style}>
      <td contenteditable='true' class='title input searchable' id='title-${link.id}'>${link.title}</td>
      <td contenteditable='true' class='input searchable' id='url-${link.id}'>${link.url}</td>
      <td id='read-${link.id}' class='status'>${link.read}</td>
      <td id='update-status-${link.id}'><button type='button' class='update-status btn btn-sm searchable'>${buttonText}</button></td>
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
  $(target).parent().parent().toggleClass('bg-success')
}

function toggleButtonText(status) {
  return status ? "Mark as Unread" : "Mark as Read"
}

function updateAjax(target, edit_data, linkID) {
  clearFields()

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

function updateLinkText() {

  $("#links-table").on('blur', '.input', e => {
    let linkID = e.currentTarget.id
    let num = linkID.replace(/^\D+/g, "")

    let titleID = "#title-" + num
    let urlID = "#url-" + num

    let edit_data = { link: { title: $(titleID).text(), url: $(urlID).text() } }

    $.ajax({
      url: "/api/v1/links/" + num,
      type: "PATCH",
      dataType: "JSON",
      data: edit_data,
      success: response => {
        $(titleID).text(response.title)
        $(urlID).text(response.url)
        clearFields()
      },
      error: error => {
        appendErrorRow(error.responseJSON.errors)
        $(titleID).text(error.responseJSON.link.title)
        $(urlID).text(error.responseJSON.link.url)
      }
    })
  })
}


function search(){
  $("#search-links").on("keyup", e => {
    let query = e.target.value.toLowerCase()

    let links = $("#table-body").children('tr')

    links.hide()

    if (query === 'read' || query === 'unread') {
      let statusQuery = query === 'read' ? 'true' : 'false'

      let matches = links.filter((index, link) => {
      return $(link)
          .children('.status')
          .text()
          .toLowerCase()
          .includes(statusQuery)
      })
      matches.show()

    } else {
      let matches = links.filter((index, link) => {
        return $(link)
          .children('.searchable')
          .text()
          .toLowerCase()
          .includes(query)
      })
      matches.show()
    }
  })
}
