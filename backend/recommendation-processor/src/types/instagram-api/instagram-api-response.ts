export type InstagramApiResponse = {
    about: null;
    account_badges: any[];
    account_type: number;
    active_standalone_fundraisers: FundraisersInfo;
    adjusted_banners_order: any[];
    ads_incentive_expiration_date: null;
    ads_page_id: null;
    ads_page_name: null;
    bio_links: BioLink[];
    biography: string;
    biography_email: null;
    biography_with_entities: BiographyWithEntities;
    business_contact_method: string;
    can_add_fb_group_link_on_profile: boolean;
    can_hide_category: boolean;
    can_hide_public_contacts: boolean;
    category: string;
    category_id: number;
    charity_profile_fundraiser_info: CharityProfileFundraiserInfo;
    contact_phone_number: string;
    current_catalog_id: null;
    direct_messaging: string;
    eligible_for_text_app_activation_badge: boolean;
    external_lynx_url: string;
    external_url: string;
    fb_page_call_to_action_id: string;
    fbid_v2: number;
    follower_count: number;
    following_count: number;
    full_name: string;
    has_active_charity_business_profile_fundraiser: boolean;
    has_anonymous_profile_picture: boolean;
    has_biography_translation: boolean;
    has_chaining: boolean;
    has_guides: boolean;
    hd_profile_pic_url_info: ImageInfo;
    hd_profile_pic_versions: ImageInfo[];
    id: string;
    is_business: boolean;
    is_call_to_action_enabled: boolean;
    is_category_tappable: boolean;
    is_eligible_for_request_message: boolean;
    is_facebook_onboarded_charity: boolean;
    is_favorite: boolean;
    is_favorite_for_clips: boolean;
    is_favorite_for_igtv: boolean;
    is_favorite_for_stories: boolean;
    is_parenting_account: boolean;
    is_private: boolean;
    is_profile_audio_call_enabled: boolean;
    is_verified: boolean;
    latest_reel_media: number;
    live_subscription_status: string;
    location_data: LocationData;
    media_count: number;
    merchant_checkout_style: string;
    page_id: null;
    page_name: null;
    pinned_channels_info: PinnedChannelsInfo;
    primary_profile_link_type: number;
    professional_conversion_suggested_account_type: number;
    profile_context: string;
    profile_context_facepile_users: any[];
    profile_context_links_with_user_ids: any[];
    profile_pic_id: string;
    profile_pic_url: string;
    profile_pic_url_hd: string;
    public_email: string;
    public_phone_country_code: string;
    public_phone_number: string;
    seller_shoppable_feed_type: string;
    show_shoppable_feed: boolean;
    third_party_downloads_enabled: number;
    total_igtv_videos: number;
    upcoming_events: any[];
    username: string;
};

type FundraisersInfo = {
    fundraisers: any[];
    total_count: number;
};

type BioLink = {
    image_url: string;
    is_pinned: boolean;
    is_verified: boolean;
    link_id: number;
    link_type: string;
    lynx_url: string;
    open_external_url_with_in_app_browser: boolean;
    title: string;
    url: string;
};

type BiographyWithEntities = {
    entities: any[];
    raw_text: string;
};

type CharityProfileFundraiserInfo = {
    consumption_sheet_config: DonationConfig;
    has_active_fundraiser: boolean;
    is_facebook_onboarded_charity: boolean;
};

type DonationConfig = {
    can_viewer_donate: boolean;
    currency: null;
    donation_amount_config: DonationAmountConfig;
    donation_disabled_message: string;
    donation_url: null;
    has_viewer_donated: null;
    privacy_disclaimer: null;
    profile_fundraiser_id: null;
    you_donated_message: null;
};

type DonationAmountConfig = {
    default_selected_donation_value: null;
    donation_amount_selector_values: any[];
    maximum_donation_amount: null;
    minimum_donation_amount: null;
    prefill_amount: null;
    user_currency: null;
};

type ImageInfo = {
    height: number;
    url: string;
    width: number;
};

type LocationData = {
    address_street: string;
    city_id: number;
    city_name: string;
    instagram_location_id: string;
    latitude: number;
    longitude: number;
    zip: string;
};

type PinnedChannelsInfo = {
    has_public_channels: boolean;
    pinned_channels_list: any[];
};
