import {CheerioAPI, load} from "cheerio";
import {INSTAGRAM_URL} from "../../constants/instagram-url";
import {FESource} from "../../types/fe-recommendation";
import axios from "axios";
import {Source} from "../../types/recommendation";
import {SourceType} from "../../constants/source-types";

export const getInstagramInfo = async (source: FESource): Promise<Source|null> => {

    const instagramUrl = `${INSTAGRAM_URL}${source.id}`
    const { data } = await axios.get(instagramUrl)
    if(data){
        return parseHtmlData(source, data)
    } else {
        console.log('Could not get instagram user\'s meta')
        return null
    }
}

const parseHtmlData = (source: FESource, data: string): Source|null => {
    const $ = load(data);
    const descriptionContent = $('meta[name="description"]').attr('content');
    const imageUrl = parseProfileImageUrl($, source)

    if(descriptionContent && imageUrl){
        const matches = parseInstagramUserMeta(descriptionContent)
        if (matches) {
            const followers = matches[1];
            const following = matches[2];
            const posts = matches[3];

            return {
                id: source.id,
                type: SourceType.INSTAGRAM,
                extra: {
                    userImageUrl: imageUrl,
                    followers: followers,
                    following: following,
                    posts: posts
                }
            }
        } else {
            console.log('The input string does not match the expected format.');
            return null;
        }
    } else {
        console.log('Could not parse description tag from HTML')
        return null
    }
}

const parseProfileImageUrl = ($:CheerioAPI, source: FESource) => {
    const alt = `${source.id}\s profile picture`
    const selector = `img[alt=${alt}]`

    const kek = 'img[alt="igoeast_\'s profile picture"]'

    return $(selector).attr('src');
}

const parseInstagramUserMeta = (userMetaTag: string) => {
    const userMeta = userMetaTag.slice(0, userMetaTag.indexOf('-')-1);
    const regex = /(\d+(?:,\d+)*[MK]?) Followers, (\d+(?:,\d+)*) Following, (\d+(?:,\d+)*) Posts/;
    return regex.exec(userMeta);
}