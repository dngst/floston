import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["scrollToTop"]

  connect() {
    this.setupScrollListener()
    this.toggleButtonVisibility()
  }

  setupScrollListener() {
    window.addEventListener('scroll', () => this.scrollFunction())
  }

  scrollFunction() {
    this.toggleButtonVisibility()
  }

  toggleButtonVisibility() {
    const scrollToTop = this.scrollToTopTarget
    scrollToTop.style.display = window.scrollY > 600 ? "block" : "none"
  }

  scrollToTop() {
    window.scrollTo({ top: 0, behavior: "smooth" })
  }

  disconnect() {
    window.removeEventListener('scroll', () => this.scrollFunction())
  }
}
