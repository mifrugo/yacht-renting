import { showLogin } from '../components/init_login'

document.addEventListener('turbolinks:load', () => {
  showLogin();
});
