$(document).ready(() => {
  (function listenForCrud() {
    getLinks()
    createLink()
    updateStatus()
    updateLinkAttributes()
    deleteLink()
    search()
  }())
})
