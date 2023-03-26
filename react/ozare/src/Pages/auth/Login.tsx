import React, { useEffect, useState } from "react";
import {
  getRedirectResult,
  signInWithEmailAndPassword,
  signInWithRedirect,
} from "firebase/auth";
import { auth, googleAuthProvider } from "./firebase";
import { useNavigate } from "react-router-dom";

const Login = (): JSX.Element => {
  const navigate = useNavigate();
  const [formValues, setFormValues] = useState<{
    email: string;
    password: string;
  }>({ email: "", password: "" });
  const [error, setError] = useState<string>("");

  const handleInputChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = event.target;
    setFormValues((prevState) => ({ ...prevState, [name]: value }));
  };

  const handleSignIn = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();

    try {
      const userCredential = await signInWithEmailAndPassword(
        auth,
        formValues.email,
        formValues.password
      );
      const user = userCredential.user;
      console.log(user);

      return true;
    } catch (error: any) {
      setError("Wrong email or password");
      return false;
    }
  };

  const handleGoogleSignIn = async () => {
    // handle Google Sign In
    try {
      await signInWithRedirect(auth, googleAuthProvider);
    } catch (error: any) {
      setError(error.message);
    }
  };

  const [loading] = useState(true);

  useEffect(() => {
    if (loading) {
      return;
    }

    getRedirectResult(auth)
      .then((result) => {
        const user = result?.user ? result.user : null;
        console.log(user);
        if (user) {
          navigate("/");
        }
      })
      .catch((error) => {
        console.error(error);
      });
  }, [loading, navigate]);

  return (
    <div className="flex flex-col w-full items-center justify-center h-screen">
      <div className="w-2/3">
        <h1 className="text-3xl font-bold mb-8">Let's Get Started</h1>

        <form
          className="flex flex-col w-full pb-6 border-b-[1px] border-gray-100"
          onSubmit={handleSignIn}
        >
          <div className="flex flex-col mt-4">
            <label htmlFor="email" className="mb-2  text-xs text-gray-500">
              Email Address
            </label>
            <input
              type="email"
              id="email"
              name="email"
              placeholder="Enter your email address"
              value={formValues.email}
              onChange={handleInputChange}
              className="mb-4 px-8 py-4   rounded-2xl bg-sky-100 text-sky-500  outline-none"
            />
          </div>

          <div className="flex flex-col mb-4">
            <label htmlFor="password" className="mb-2 text-xs text-gray-500">
              Password
            </label>
            <input
              type="password"
              id="password"
              name="password"
              placeholder="Enter your password"
              value={formValues.password}
              onChange={handleInputChange}
              className="mb-4 px-8 py-4  rounded-2xl bg-sky-100 text-sky-500  outline-none"
            />
          </div>
          {error && (
            <p className="text-red-500 text-xs text-center mb-4">{error}</p>
          )}

          <button className="px-8 rounded-2xl py-4 bg-sky-500 text-white disabled:bg-gray-300">
            Sign In
          </button>
        </form>

        <button
          onClick={handleGoogleSignIn}
          className="px-8 w-full mt-6 rounded-2xl py-4 bg-sky-500 text-white disabled:bg-gray-300"
        >
          Sign In With Google
        </button>
        <div>
          <p className="text-center mt-4">
            Don't have an account?{" "}
            <a href="/auth/register" className="text-sky-500 font-bold">
              Register
            </a>
          </p>
        </div>
      </div>
    </div>
  );
};

export default Login;
