function deleteLink() {
  $("#links-table").on('click', '.delete', e => {

    var id = e.currentTarget.id

    $.ajax({
      url: "/api/v1/links/" + id,
      type: "DELETE",
      dataType: "JSON",
      success: response => removeRow(id),
      error: error => console.log(error)
    })
  })
}
