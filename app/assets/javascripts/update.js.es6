function updateStatus() {
  $("#links-table").on('click', '.update-status', e => {
    let target = e.currentTarget
    let linkID = $(target).parent()[0].id.replace(/^\D+/g, "")

    let currentStatus = $(target).parent().prev()[0].innerText
    let updateStatus =  currentStatus === "false" ? true : false

    let edit_data = { link: { read: updateStatus } }
    let url = "/api/v1/links/" + linkID
    updateRequest(target, url, edit_data, linkID, updateStatusActions)
  })
}

function updateStatusActions(target, response) {
  toggleReadText(target, response.read)
  clearFields()
}

function attributesSuccessActions(response) {
  $('#flash').html(
    `<div class='alert alert-success fade in' role='alert'>Updated successfully! 
       <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>
     </div>`
   )

  $(titleID).text(response.title)
  $(urlID).text(response.url)
  $('.bg-danger').remove()
}

function attributesErrorActions(error) {
  let id = error.responseJSON.link.id

  appendErrorRow(error.responseJSON.errors)
  $(`#title-${id}`).text(error.responseJSON.link.title)
  $(`#url-${id}`).text(error.responseJSON.link.url)
}

function updateRequest(target, path, edit_data, linkID, successAction) {
  $.ajax({
    url: path,
    type: "PATCH",
    dataType: "JSON",
    data: edit_data,
    success: response => successAction(target, response),
    error: error => console.log(error),
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
      success: response => attributesSuccessActions(response),
      error: error => attributesErrorActions(error),
    })
  })
}
