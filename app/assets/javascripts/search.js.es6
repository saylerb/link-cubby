function search(){
  $("#search-links").on("keyup", e => {
    let query = e.target.value.toLowerCase()

    let links = $("#table-body").children('tr')

    links.hide()

    if (query === 'read' || query === 'unread') {
      let statusQuery = query === 'read' ? 'true' : 'false'

      let matches = links.filter((index, link) => {
      return $(link)
          .children('.status')
          .text()
          .toLowerCase()
          .includes(statusQuery)
      })
      matches.show()

    } else {
      let matches = links.filter((index, link) => {
        return $(link)
          .children('.searchable')
          .text()
          .toLowerCase()
          .includes(query)
      })
      matches.show()
    }
  })
}
