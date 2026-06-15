// Reads the _on_ruby_user data cookie (set by UserHandling#sign_in) and swaps the
// anonymous login button for the profile dropdown without a server round-trip.
Controllers['nav'] = class {
  constructor(el) { this.el = el; }

  connect() {
    const user = this.readUserCookie();
    if (user) this.renderUserNav(user);
  }

  readUserCookie() {
    const match = document.cookie.match(/(?:^|;\s*)_on_ruby_user=([^;]+)/);
    if (!match) return null;
    try { return JSON.parse(decodeURIComponent(match[1])); }
    catch (e) { return null; }
  }

  renderUserNav(user) {
    const template = this.el.querySelector('template');
    if (!template) return;

    const frag = template.content.cloneNode(true);
    const avatar = frag.querySelector('[data-avatar]');
    avatar.src = user.image_path;
    avatar.alt = user.name;
    frag.querySelector('[data-profile]').href = user.profile_path;
    frag.querySelector('[data-edit]').href = user.edit_path;
    frag.querySelector('[data-logout]').href = user.logout_path;

    const show = (sel) => { const node = frag.querySelector(sel); if (node) node.hidden = false; };
    if (user.is_admin) show('[data-admin]');
    if (user.is_super_admin) show('[data-super-admin]');

    this.el.querySelector('[data-login]').replaceWith(frag);
  }
};
