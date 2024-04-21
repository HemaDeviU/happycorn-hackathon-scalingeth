import MaxWrapper from "@/components/shared/max-wrapper";
import { cn } from "@/lib/utils";
import { polyFont } from "../layout";
import { Button } from "@/components/ui/button";
import CategorySection from "@/components/sections/CategorySection";
import ListingSection from "@/components/sections/ListingSection";

export default function Home() {
  return (
    <div className="w-full flex-1">
      <div className="w-full bg-primary/10">
        <MaxWrapper className="py-20 flex flex-col justify-center items-center gap-4">
          <h1
            className={cn(
              "text-3xl md:text-4xl font-regular text-center",
              polyFont.className
            )}>
            Celebrate EVERY moment with gifts from small shops!
          </h1>
          <p className="text-base md:text-lg text-center max-w-prose">
            Lorem ipsum dolor, sit amet consectetur adipisicing elit. Itaque vel
            assumenda ipsum provident vitae neque maxime numquam laboriosam quia
            dignissimos.
          </p>

          <Button size="lg" className="rounded-full">
            View Listings
          </Button>
        </MaxWrapper>
      </div>

      {/* <CategorySection /> */}
      <ListingSection />
    </div>
  );
}
