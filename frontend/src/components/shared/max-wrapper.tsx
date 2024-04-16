import { cn } from "@/lib/utils";

export default function MaxWrapper({ children, className }: MaxWrapperProps) {
  return (
    <section className={cn("max-w-[1400px] mx-auto px-4", className)}>
      {children}
    </section>
  );
}
