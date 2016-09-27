function updateStatus() {
  $("#links-table").on('click', '.update-status', e => {
    let linkID = $(e.currentTarget).parents(':first').attr('id').replace(/^\D+/g, "")
    let currentStatus = $(e.currentTarget).parent().prev().text()

    updateRequest(
      statusPayload(currentStatus),
      linkID,
      updateStatusActions,
      err => console.log(err.responseText)
    )
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

function attributesErrorActions(errorRes) {
  let linkID = errorRes.link.id

  appendErrorRow(errorRes.errors)
  $(`#title-${linkID}`).text(errorRes.link.title)
  $(`#url-${linkID}`).text(errorRes.link.url)
}

function updateLinkAttributes() {
  $("#links-table").on('blur', '.input', e => {
    let linkID = e.currentTarget.id.replace(/^\D+/g, "")

    updateRequest(
      linkPayload(linkID),
      linkID, 
      attributesSuccessActions, 
      attributesErrorActions
    )
  })
}

function statusPayload(currentStatus) {
  let updateStatus =  currentStatus === "false" ? true : false
  return { link: { read: updateStatus } }
}

function linkPayload(linkID) {
  let titleText = $(`#title-${linkID}`).text()
  let urlText = $(`#url-${linkID}`).text()

  return { link: { title: titleText, url: urlText } }
}

function updateRequest(payload, linkID, successAction, errorAction) {

  let request = new Request(`/api/v1/links/${linkID}`,
    { method: 'PATCH',
      headers: { 'Content-Type': 'application/json' },
      credentials: 'same-origin',
      body: JSON.stringify(payload)
    })

  fetch(request)
    .then(response => {
      response.json()
        .then(json => response.ok ? successAction(linkID, json) : errorAction(json))
    })
    .catch(error => console.log(error))
}
