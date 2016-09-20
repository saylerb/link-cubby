function getLinks() {
  let request = new Request('/api/v1/links.json', { method: 'GET', credentials: 'same-origin' })

  fetch(request)
    .then(response => response.json())
    .then(response => response.forEach(link => appendRow(link)))
    .catch(err => console.log(err))
}
