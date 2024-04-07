class PayloadModel {
  final String title = 'Title';
  final String description = 'qwe';
  final SocialLinks socialLinks = SocialLinks();
  final String city = 'Montreal';

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'socialLinks': socialLinks.toJson(),
      'city': city,
    };
  }
}

class SocialLinks {
  final String instagram = 'sdojfnsdnfsd';
  final String facebook = 'sdojfnsdnfsd';
  final String telegram = 'sdojfnsdnfsd';
  final String webSite = 'sdojfnsdnfsd';

  Map<String, dynamic> toJson() {
    return {
      'instagram': instagram,
      'facebook': facebook,
      'telegram': telegram,
      'webSite': webSite,
    };
  }
}
