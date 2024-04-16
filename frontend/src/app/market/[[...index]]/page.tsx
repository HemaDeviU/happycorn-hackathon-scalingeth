import { polyFont } from "@/app/layout";
import NFTCard from "@/components/cards/NFTCard";
import MaxWrapper from "@/components/shared/max-wrapper";
import { cn } from "@/lib/utils";

export default function MarketPage() {
  return (
    <div className="flex-1 py-4">
      <MaxWrapper className="flex flex-col gap-4">
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

        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
          {Array.from({ length: 12 }).map((_: any, _key: number) => (
            <NFTCard key={_key} id={_key + Math.random()} />
          ))}
        </div>
      </MaxWrapper>
    </div>
  );
}
