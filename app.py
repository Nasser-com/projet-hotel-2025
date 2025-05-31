import streamlit as st
import sqlite3

# Connexion à la base
conn = sqlite3.connect("hotel.db")
cur = conn.cursor()

st.title("🏨 Application de gestion d'hôtel")

# Menu
choix = st.sidebar.selectbox("📌 Menu", [
    "🏷️ Voir les clients",
    "➕ Ajouter un client",
    "📅 Voir chambres disponibles",
    "📋 Voir les réservations"
])

# Voir les clients
if choix == "🏷️ Voir les clients":
    cur.execute("SELECT id_client, nom, ville, email FROM Client")
    clients = cur.fetchall()
    st.subheader("Liste des clients")
    for c in clients:
        st.write(f"🧍 {c[1]} - {c[2]} - {c[3]}")

# Ajouter un client
elif choix == "➕ Ajouter un client":
    st.subheader("Ajouter un nouveau client")
    nom = st.text_input("Nom")
    adresse = st.text_input("Adresse")
    ville = st.text_input("Ville")
    code_postal = st.number_input("Code postal", step=1)
    email = st.text_input("Email")
    telephone = st.text_input("Téléphone")
    if st.button("Ajouter"):
        cur.execute("INSERT INTO Client (adresse, ville, code_postal, email, telephone, nom) VALUES (?, ?, ?, ?, ?, ?)",
                    (adresse, ville, code_postal, email, telephone, nom))
        conn.commit()
        st.success("✅ Client ajouté avec succès")

# Voir les chambres disponibles
elif choix == "📅 Voir chambres disponibles":
    st.subheader("Chambres disponibles")
    date_debut = st.date_input("Date de début")
    date_fin = st.date_input("Date de fin")
    if st.button("Rechercher"):
        query = """
        SELECT * FROM Chambre
        WHERE id_chambre NOT IN (
            SELECT id_chambre FROM Reservation
            WHERE date_debut < ? AND date_fin > ?
        )
        """
        cur.execute(query, (date_fin, date_debut))
        chambres = cur.fetchall()
        st.write("📂 Chambres disponibles :")
        for ch in chambres:
            st.write(f"🛏️ Chambre {ch[1]} à l’étage {ch[2]} (type {ch[4]})")

# Voir les réservations
elif choix == "📋 Voir les réservations":
    st.subheader("Toutes les réservations")
    query = """
    SELECT r.id_reservation, c.nom, r.date_debut, r.date_fin
    FROM Reservation r
    JOIN Client c ON r.id_client = c.id_client
    """
    cur.execute(query)
    reservations = cur.fetchall()
    for r in reservations:
        st.write(f"📅 {r[1]} a réservé du {r[2]} au {r[3]}")

# Fermer la base
conn.close()
