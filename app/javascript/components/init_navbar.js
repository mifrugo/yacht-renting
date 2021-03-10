const navBar = () => {
  document.addEventListener('scroll', () => {

    const jumb = document.querySelector('.jumbotron') || null

    if (jumb !== null) {
      const nav = document.querySelector('nav');
      if (window.scrollY >= jumb.offsetHeight) {
        nav.classList.add('scrolled');
      } else {
        nav.classList.remove('scrolled')
      }
    }

  });
};
export { navBar };
