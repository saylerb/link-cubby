function updateStatus() {
  $("#links-table").on('click', '.update-status', e => {
    let target = e.currentTarget
    let linkID = $(target).parent()[0].id.replace(/^\D+/g, "")

    let currentStatus = $(target).parent().prev()[0].innerText
    let updateStatus =  currentStatus === "false" ? true : false

    let edit_data = { link: { read: updateStatus } }
    let url = "/api/v1/links/" + linkID
    updateRequest(edit_data, linkID, updateStatusActions, e => console.log(e.responseText))
  })
}

function updateStatusActions(linkID, response) {
  toggleReadText(linkID, response.read)
  clearFields()
}

function attributesSuccessActions(linkID, response) {
  $('#flash-message').html(
    `<div class='alert alert-success fade in' role='alert'>Updated successfully! 
       <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>
     </div>`
   )

  $(`title-${linkID}`).text(response.title)
  $(`url-${linkID}`).text(response.url)
  $('.bg-danger').remove()
}

function attributesErrorActions(error) {
  let errorRes = error.responseJSON 
  let linkID = errorRes.link.id

  appendErrorRow(errorRes.errors)
  $(`#title-${linkID}`).text(errorRes.link.title)
  $(`#url-${linkID}`).text(errorRes.link.url)
}

function updateLinkAttributes() {
  $("#links-table").on('blur', '.input', e => {
    let linkID = e.currentTarget.id.replace(/^\D+/g, "")

    updateRequest(
      packageLinkData(linkID), 
      linkID, 
      attributesSuccessActions, 
      attributesErrorActions
    )
  })
}

function updateRequest(edit_data, linkID, successAction, errorAction) {
  $.ajax({
    url: `/api/v1/links/${linkID}`,
    type: "PATCH",
    dataType: "JSON",
    data: edit_data,
    success: response => successAction(linkID, response),
    error: error => errorAction(error)
  })
}

function packageLinkData(linkID) {
  let titleText = $(`#title-${linkID}`).text()
  let urlText = $(`#url-${linkID}`).text()

  return { link: { title: titleText, url: urlText } }
}
