#include <stdint.h>

#define SERPENT_MIN_KEY_SIZE		  0
#define SERPENT_MAX_KEY_SIZE		 32
#define SERPENT_EXPKEY_WORDS		132
#define SERPENT_BLOCK_SIZE		 16

struct serpent_ctx {
	uint32_t expkey[SERPENT_EXPKEY_WORDS];
};

extern void serpent_init(struct serpent_ctx *ctx, const uint8_t *key, unsigned int keybytes);
