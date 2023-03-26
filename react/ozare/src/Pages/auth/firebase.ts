import { initializeApp } from "firebase/app";
import {
  getAuth,
  GoogleAuthProvider,
  setPersistence,
  browserSessionPersistence,
} from "firebase/auth";
import { getFirestore } from "firebase/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyC7o5IcqvP1IV0z_vHXDFOdAKGAtIB5rCs",
  appId: "1:577898555257:web:b7851ae497b955a2b371a8",
  messagingSenderId: "577898555257",
  projectId: "ozare-e8ed6",
  authDomain: "ozare-e8ed6.firebaseapp.com",
  storageBucket: "ozare-e8ed6.appspot.com",
  measurementId: "G-DXXW2GQCCJ",
};

const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const db = getFirestore();
const googleAuthProvider = new GoogleAuthProvider();

setPersistence(auth, browserSessionPersistence)
  .then(() => {})
  .catch((error) => {
    console.error(error);
  });

export { auth, db, googleAuthProvider };
