#!/bin/bash
# Provjera je li korisnik root
if [ "$EUID" -ne 0 ]; then
  echo "[GREŠKA] Pokreni ovu skriptu kao root (sudo)."
  exit 1
fi

while true; do
  clear
  echo "🧑‍💻  USER MANAGER (Ubuntu CLI alat)"
  echo "-----------------------------------"
  echo "1. Promijeni lozinku korisniku"
  echo "2. Promijeni ime korisnika"
  echo "3. Promijeni default shell"
  echo "4. Dodaj korisnika u grupu (npr. sudo)"
  echo "5. Obriši korisnika"
  echo "6. Izađi"
  echo "-----------------------------------"
  read -p "Odaberi opciju [1-6]: " opcija

  case $opcija in
    1)
      read -p "Unesi korisničko ime: " user
      id "$user" &>/dev/null || { echo "[GREŠKA] Korisnik ne postoji."; sleep 2; continue; }
      passwd "$user"
      ;;
    2)
      read -p "Trenutno korisničko ime: " oldname
      read -p "Novo korisničko ime: " newname
      id "$oldname" &>/dev/null || { echo "[GREŠKA] Korisnik ne postoji."; sleep 2; continue; }
      usermod -l "$newname" "$oldname"
      usermod -d "/home/$newname" -m "$newname"
      echo "[OK] Promijenjeno ime korisnika."
      ;;
    3)
      read -p "Unesi korisničko ime: " user
      id "$user" &>/dev/null || { echo "[GREŠKA] Korisnik ne postoji."; sleep 2; continue; }
      read -p "Unesi novi shell (npr. /bin/bash, /bin/zsh): " shell
      chsh -s "$shell" "$user"
      echo "[OK] Shell promijenjen."
      ;;
    4)
      read -p "Unesi korisničko ime: " user
      id "$user" &>/dev/null || { echo "[GREŠKA] Korisnik ne postoji."; sleep 2; continue; }
      read -p "Unesi grupu (npr. sudo, audio): " group
      usermod -aG "$group" "$user"
      echo "[OK] Dodan u grupu $group."
      ;;
    5)
      read -p "Unesi korisničko ime za brisanje: " user
      id "$user" &>/dev/null || { echo "[GREŠKA] Korisnik ne postoji."; sleep 2; continue; }
      read -p "Jesi li siguran? (da/ne): " potvrda
      if [ "$potvrda" == "da" ]; then
        userdel -r "$user"
        echo "[OK] Korisnik '$user' obrisan."
      else
        echo "[INFO] Brisanje otkazano."
      fi
      ;;
    6)
      echo "👋 Izlaz iz user-managera..."
      break
      ;;
    *)
      echo "[GREŠKA] Nevažeći odabir."
      sleep 1
      ;;
  esac

  echo ""
  read -p "Pritisni Enter za nastavak..."
done
