import {GoogleAddress} from "../../types/recommendation";
export const getGoogleAddress = (formattedAddress: string): GoogleAddress => {
    const [street, city, provinceWithPostalCode, country] = formattedAddress.split(',')
    const parsedProvince = parseProvinceAndPostalCode(provinceWithPostalCode)
    const trimmedCity = trim(city)
    const trimmedProvince = trim(parsedProvince.province)
    return {
        street: trim(street),
        city: trimmedCity,
        province: trimmedProvince,
        postalCode: parsedProvince.postalCode,
    }
}

const trim = (value: string) => {
    return value.trimStart().trimEnd()
}

const parseProvinceAndPostalCode = (provinceWithPostalCode: string) => {
    provinceWithPostalCode = trim(provinceWithPostalCode)
    const postalCode = provinceWithPostalCode.substring(provinceWithPostalCode.length-7);
    const province = provinceWithPostalCode.substring(0, provinceWithPostalCode.length-7)
    return {
        province: province,
        postalCode: postalCode
    }
}