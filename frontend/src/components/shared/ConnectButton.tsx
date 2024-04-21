"use client";

import {
  useWeb3ModalTheme,
  useWeb3ModalAccount,
} from "@web3modal/ethers/react";
import { Button } from "../ui/button";

export default function ConnectButton() {
  const { address, chainId, isConnected } = useWeb3ModalAccount();
  const { setThemeVariables } = useWeb3ModalTheme();

  setThemeVariables({
    "--w3m-accent": "hsl(var(--primary))",
  });

  return (
    <div className="flex justify-end max-w-[284px] flex-1">
      <w3m-button /> {isConnected ? <Button>Sell Item</Button> : null}
    </div>
  );
}
