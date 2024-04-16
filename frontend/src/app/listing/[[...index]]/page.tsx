import { polyFont } from "@/app/layout";
import MaxWrapper from "@/components/shared/max-wrapper";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import { Check } from "lucide-react";

export default function ListingPage() {
  return (
    <div className="flex-col">
      <MaxWrapper className="py-10">
        <div className="flex flex-col lg:flex-row gap-6">
          <div className="flex gap-3 flex-col-reverse xl:flex-row max-h-[600px]">
            <div className="flex flex-row xl:flex-col w-full h-full overflow-x-auto overscroll-y-none xl:overscroll-x-none xl:overflow-y-auto xl:w-max gap-3">
              {Array.from({ length: 4 }).map((_, _key) => (
                <div
                  className="bg-secondary rounded h-24 aspect-[1.2]"
                  key={_key}></div>
              ))}
            </div>
            <div className="h-[600px] aspect-square bg-secondary"></div>
          </div>

          <div className="flex flex-col flex-1 px-0 md:px-5">
            <h1
              className={cn(
                "text-2xl md:text-3xl font-medium",
                polyFont.className
              )}>
              Lorem ipsum dolor sit amet, consectetur adipisicing elit.
              Voluptas, ipsam.
            </h1>
            <p className="text-base mt-1 mb-2">
              Lorem ipsum dolor sit amet consectetur adipisicing elit. Odio,
              delectus autem nobis, veritatis, perferendis doloribus debitis
              odit molestias id impedit rerum nam eos porro. Velit inventore
              eveniet ex excepturi consectetur!
            </p>
            <p className="text-base md:text-xl font-bold text-green-600 mb-2">
              USD 5.40
            </p>

            <p className="text-sm font-normal flex items-center gap-2 mb-6">
              <Check className="w-4 h-4 text-green-600" />
              Arrives soon! Get it by Apr 17-23 if you order today
            </p>

            <div className="flex flex-col gap-4">
              <Button
                size="lg"
                className="w-full rounded-full h-12 uppercase font-semibold border-2 border-secondary-foreground/25"
                variant="outline">
                Add to Cart
              </Button>
              <Button
                size="lg"
                className="w-full rounded-full h-12 uppercase font-semibold">
                Buy Now
              </Button>
            </div>
          </div>
        </div>
      </MaxWrapper>
    </div>
  );
}
