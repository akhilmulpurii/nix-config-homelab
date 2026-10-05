{ ... }:

{
  services.printing.enable = true;
  services.cockpit.enable = true;

  # ── Global keyring ────────────────────────────────────────
  services.gnome.gnome-keyring.enable = true;

  # Unlock the keyring automatically when the user logs in via PAM.
  security.pam.services = {
    login.enableGnomeKeyring        = true;
    gdm.enableGnomeKeyring          = true;
    gdm-password.enableGnomeKeyring = true;
    lightdm.enableGnomeKeyring      = true;
    sddm.enableGnomeKeyring         = true;
    greetd.enableGnomeKeyring       = true;
  };
  # ──────────────────────────────────────────────────────────
}
