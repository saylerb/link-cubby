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
      <td id='update-status-${link.id}'><button type='button' class='update-status btn btn-sm searchable'>${buttonText}</button></td>
    </tr>`
  )
}
