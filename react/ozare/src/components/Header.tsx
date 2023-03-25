import BackButton from "./BackButton";
import TonCoin from "../assets/images/ton-coin.svg";

function Header({
  title,
  showBack = true,
  paddingBottom = "pb-4",
  children,
}: {
  title?: string;
  showBack?: boolean;
  paddingBottom?: `pb-${string}`;
  children?: React.ReactNode;
}) {
  return (
    <section
      className={
        "sticky z-10 top-0 px-4 pt-4 bg-gradient-to-br from-sky-400 via-sky-300 to-sky-400 " +
        paddingBottom
      }
    >
      <div className="flex px-4 flex-row items-center justify-between">
        <div className="flex items-center justify-start gap-x-4">
          {showBack && <BackButton />}
          {title && <h1 className="text-white font-bold text-xl">{title}</h1>}
        </div>
        <button
          onClick={(e) => console.log(e)}
          className="bg-white px-2 items-center py-1 flex justify-start flex-row rounded-full"
        >
          <img src={TonCoin} className="h-8 w-8 pr-2" alt="ton-coin" />
          <span className="text-sky-500 pr-2">Connect</span>
        </button>
      </div>
      {children}
    </section>
  );
}

export default Header;
