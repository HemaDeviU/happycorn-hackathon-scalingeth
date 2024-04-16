import { polyFont } from "@/app/layout";
import MaxWrapper from "@/components/shared/max-wrapper";
import { cn } from "@/lib/utils";

export default function MarketPage() {
  return (
    <div className="flex-1 py-4">
      <MaxWrapper>
        <div className="flex items-end gap-3">
          <h1
            className={cn(
              "text-2xl md:text-3xl font-light",
              polyFont.className
            )}>
            Gift for Men
          </h1>
          <p className="text-xs font-normal mb-1">
            (1,000+ relevant results, with Ads)
          </p>
        </div>
      </MaxWrapper>
    </div>
  );
}
