import { describe, it, expect } from "vitest";
import {getGoogleAddress} from "../src/service/google-api/google-address-parser";

describe("getGoogleAddress", () => {
    it("parses a well-formed address correctly", () => {
        const formattedAddress = "123 Maple St, Springfield, QC H3C 1A1, Canada";
        const expected = {
            street: "123 Maple St",
            city: "Springfield",
            province: "QC",
            postalCode: "H3C 1A1",
        };
        const result = getGoogleAddress(formattedAddress);
        expect(result).toEqual(expected);
    });

    it("trims additional whitespace from the address components", () => {
        const formattedAddress = " 123 Maple St , Springfield , QC H3C 1A1 , Canada ";
        const expected = {
            street: "123 Maple St",
            city: "Springfield",
            province: "QC",
            postalCode: "H3C 1A1",
        };
        const result = getGoogleAddress(formattedAddress);
        expect(result).toEqual(expected);
    });

});
