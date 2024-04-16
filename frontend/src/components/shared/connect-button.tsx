"use client";

import { useWeb3ModalTheme } from "@web3modal/ethers/react";

export default function ConnectButtonComponent() {
  const { setThemeVariables } = useWeb3ModalTheme();

  setThemeVariables({
    "--w3m-accent": "hsl(var(--primary))",
  });

  return (
    <div className="flex justify-end max-w-[284px] flex-1">
      <w3m-button />
    </div>
  );
}
