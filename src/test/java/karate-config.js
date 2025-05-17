function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,

    baseURL: 'https://api.thecatapi.com/v1',

    apiKey : 'live_y6WPu13RTW3bmF8UqdqZiRj4CVW3WPGG3ecz8bISnPevsOXgGjudgsuMgGfIyvCm',

    testImageId : 'ol',

    imageSchema : { 'breeds': '##([breedSchema])', id: '#string', url: '#string',  width: '#number', height: '#number', sub_id: '##string', 'categories' : '##([categoriesSchema])' },

    categoriesSchema : { id: '#number', name: '#string'},

    sourceSchema : {id: '#number', name: '#string', url: '#string', breed_id: '##string'},

    breedSchema :    {
        'weight': {
          'imperial': '##string',
          'metric': '##string'
        },
        'id': '#string',
        'name': '#string',
        'cfa_url': '##string',
        'vetstreet_url': '##string',
        'vcahospitals_url': '##string',
        'temperament': '##string',
        'origin': '##string',
        'country_codes': '##string',
        'country_code': '##string',
        'description': '##string',
        'life_span': '##string',
        'indoor': '##number',
        'lap': '##number',
        'alt_names': '##string',
        'adaptability': '##number',
        'affection_level': '##number',
        'child_friendly': '##number',
        'cat_friendly': '##number',
        'dog_friendly': '##number',
        'energy_level': '##number',
        'grooming': '##number',
        'health_issues': '##number',
        'intelligence': '##number',
        'shedding_level': '##number',
        'social_needs': '##number',
        'stranger_friendly': '##number',
        'vocalisation': '##number',
        'bidability': '##number',
        'experimental': '##number',
        'hairless': '##number',
        'natural': '##number',
        'rare': '##number',
        'rex': '##number',
        'suppressed_tail': '##number',
        'short_legs': '##number',
        'wikipedia_url': '##string',
        'hypoallergenic': '##number',
        'reference_image_id': '##string',
        'image': '##(imageSchema)'
      },

      voteSchema : {
                       'id': '#number',
                       'image_id': '#string',
                       'user_id': '##string',
                       'sub_id': '##string',
                       'created_at': '#string',
                       'value': '#number',
                       'country_code': '#string',
                       'image': {
                           'id': '##string',
                           'url': '##string'
                           }
                   },

      favouriteSchema : {
                              'id': '#number',
                              'user_id': '#string',
                              'image_id': '#string',
                              'sub_id': '##string',
                              'created_at': '#string',
                              'image': {
                                  'id': '##string',
                                  'url': '##string'
                              }
                          }

  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}