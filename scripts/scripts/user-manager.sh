#!/bin/bash

while true; do
  clear
  echo "🧑‍💻  USER MANAGER (Linux CLI alat)"
  echo "-----------------------------------"
  echo "1. Promijeni lozinku korisniku"
  echo "2. Promijeni ime korisnika"
  echo "3. Promijeni default shell"
  echo "4. Dodaj korisnika u grupu"
  echo "5. Obriši korisnika"
  echo "6. Izađi"
  echo "-----------------------------------"
  read -p "Odaberi opciju [1-6]: " opcija

  case $opcija in
    1)
      read -p "Unesi korisničko ime: " user
      passwd "$user"
      ;;
    2)
      read -p "Trenutno korisničko ime: " oldname
      read -p "Novo korisničko ime: " newname
      usermod -l "$newname" "$oldname"
      usermod -d "/home/$newname" -m "$newname"
      echo "[OK] Promijenjeno ime korisnika."
      ;;
    3)
      read -p "Unesi korisničko ime: " user
      read -p "Unesi novi shell (/bin/bash, /bin/zsh...): " shell
      chsh -s "$shell" "$user"
      echo "[OK] Shell promijenjen."
      ;;
    4)
      read -p "Unesi korisničko ime: " user
      read -p "Unesi grupu (npr. wheel, audio): " group
      usermod -aG "$group" "$user"
      echo "[OK] Dodan u grupu."
      ;;
    5)
      read -p "Unesi korisničko ime za brisanje: " user
      read -p "Jesi li siguran? (da/ne): " potvrda
      if [ "$potvrda" == "da" ]; then
        userdel -r "$user"
        echo "[OK] Korisnik obrisan."
      else
        echo "[INFO] Prekid brisanja."
      fi
      ;;
    6)
      echo "👋 Izlaz..."
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

