function clearFields() {
  $("#title-field").val("")
  $("#url-field").val("")
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
      <td id='update-status-${link.id}'>
        <button type='button' class='update-status btn btn-sm btn-primary searchable'>${buttonText}</button>
      </td>
      <td id='delete-${link.id}'>
        <button id='${link.id}' type='button' class='delete btn btn-sm btn-danger'>Delete</button>
      </td>
    </tr>`
  )
}

function removeRow(link_id) {
  $(`#link-${link_id}`).remove()
}

function toggleReadText(target, status) {
  $(target).parent().prev().text(status)
  $(target).text(toggleButtonText(status))
  $(target).parent().parent().toggleClass('bg-success')
}

function toggleButtonText(status) {
  return status ? "Mark as Unread" : "Mark as Read"
}
