function createLink() {
  $("#submit-link").on('click', e => {
    e.preventDefault()

    let request = new Request('/api/v1/links')
    let form = new FormData(document.getElementById('new-link'))

    fetch(request, {
      method: 'POST',
      credentials: 'same-origin',
      body: form
    })
    .then(response => {
      response.json().then(json => {
        if (response.ok) {
          appendRow(json)
          clearFields()
          $('.bg-danger').remove()
        } else {
          appendErrorRow(json)
        }
      })
    })
    .catch(error => console.log(error))
  })
}
