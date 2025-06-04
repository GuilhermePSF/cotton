let Hooks = {}

Hooks.Draggable = {
  mounted() {
    const el = this.el
    const header = el.querySelector('.title-bar')
    let isDragging = false
    let offsetX, offsetY

    header.addEventListener("mousedown", (e) => {
      isDragging = true
      offsetX = e.clientX - el.offsetLeft
      offsetY = e.clientY - el.offsetTop
      document.body.style.userSelect = "none"
    })

    document.addEventListener("mousemove", (e) => {
      if (!isDragging) return
      el.style.left = `${e.clientX - offsetX}px`
      el.style.top = `${e.clientY - offsetY}px`
    })

    document.addEventListener("mouseup", () => {
      isDragging = false
      document.body.style.userSelect = ""
    })
  }
}

export default Hooks
