import { polyFont } from "@/app/layout";
import { cn } from "@/lib/utils";
import MaxWrapper from "../shared/max-wrapper";
import CategoryCard from "../cards/CategoryCard";

export default function CategorySection() {
  return (
    <div className="py-20">
      <MaxWrapper className="flex flex-col gap-4">
        <h1
          className={cn("text-2xl md:text-3xl font-light", polyFont.className)}>
          Shop our popular NFT categories
        </h1>

        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
          {Array.from({ length: 4 }).map((_: any, _key: number) => (
            <CategoryCard key={_key} id={_key + Math.random()} />
          ))}
        </div>
      </MaxWrapper>
    </div>
  );
}
