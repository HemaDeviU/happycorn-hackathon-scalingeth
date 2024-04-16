import { polyFont } from "@/app/layout";
import { cn } from "@/lib/utils";
import MaxWrapper from "../shared/max-wrapper";
import ListingCard from "../cards/ListingCard";

export default function ListingSection() {
  return (
    <div className="py-20">
      <MaxWrapper className="flex flex-col gap-4">
        <h1
          className={cn("text-2xl md:text-3xl font-light", polyFont.className)}>
          Some of the best Listings
        </h1>

        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
          {Array.from({ length: 10 }).map((_: any, _key: number) => (
            <ListingCard key={_key} id={_key + Math.random()} />
          ))}
        </div>
      </MaxWrapper>
    </div>
  );
}
