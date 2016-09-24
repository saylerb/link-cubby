function updateStatus() {
  $("#links-table").on('click', '.update-status', e => {
    let target = e.currentTarget
    let linkID = $(target).parent()[0].id.replace(/^\D+/g, "")

    let currentStatus = $(target).parent().prev()[0].innerText
    let updateStatus =  currentStatus === "false" ? true : false

    let edit_data = { link: { read: updateStatus } }
    updateRequest(target, edit_data, linkID)
  })
}

function updateStatusActions(target, response) {
  toggleReadText(target, response.read)
  clearFields()
}


function updateRequest(target, edit_data, linkID, action) {

  $.ajax({
    url: "/api/v1/links/" + linkID,
    type: "PATCH",
    dataType: "JSON",
    data: edit_data,
    success: response => {
      updateStatusActions(target, response)
    },
    error: error => {
      console.log(error)
    }
  })
}

function updateLinkAttributes() {
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
        $('.bg-danger').remove()
      },
      error: error => {
        appendErrorRow(error.responseJSON.errors)
        $(titleID).text(error.responseJSON.link.title)
        $(urlID).text(error.responseJSON.link.url)
      }
    })
  })
}
