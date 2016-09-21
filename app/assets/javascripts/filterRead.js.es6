function filterRead() {
  $('.read-filter').on('click', e => {
    e.preventDefault()
    let read = $(e.target).data('read')
    let links = $("#table-body").children('tr')
    links.hide()

    if (read === 'all') {
      links.show()
    } else {
      let matches = links.filter((index, link) => {
        return $(link)
            .children('.status')
            .text()
            .toLowerCase()
            .includes(read)
      })
    matches.show()
    }
  })
}
